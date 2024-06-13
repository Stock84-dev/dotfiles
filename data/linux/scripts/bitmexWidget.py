# -*- coding: utf-8 -*-
# Copyright (c) 2013 Jendrik Poloczek
# Copyright (c) 2013 Tao Sauvage
# Copyright (c) 2014 Aborilov Pavel
# Copyright (c) 2014 Sean Vig
# Copyright (c) 2014-2015 Tycho Andersen
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

#NOTE: websocket-client v0.56 required
import websocket
import threading
import time
import math
import calendar
import datetime

from libqtile.widget import base

from bitmex_websocket.constants import InstrumentChannels
from bitmex_websocket import Instrument
import ccxt

class BitmexWidget(base.InLoopPollText):

    def get_average(self, series):
        sum = 0
        for i in series:
            sum += i
        return sum / len(series)

    def get_stdev(self, series):
        sum = 0
        mean = self.get_average(series)
        for i in series:
            sum += (i - mean) * (i - mean)
        return math.sqrt(1 / len(series) * sum)

    def on_message(self, message):
        self.message_received = True
        msg_type = -1
        try:
            if message['table'] == 'tradeBin1m' and message['action'] == 'partial':
                return
            elif message['table'] == "tradeBin1m":
                msg_type = 1
            elif message['table'] == "trade":
                msg_type = 2
        except:
            msg_type = -1

        if msg_type == 1:
            del self.candles[0]
            del self.candles[-1]
            self.candles.append([0, message['data'][0]['open'], message['data'][0]['high'], message['data'][0]['low'],
                                 message['data'][0]['close'], message['data'][0]['volume']])
            self.candles.append([0, message['data'][0]['open'], message['data'][0]['high'], message['data'][0]['low'],
                                 message['data'][0]['close'], message['data'][0]['volume']])
        elif msg_type == 2:
            try:
                current_price = message['data'][0]['price']
            except:
                current_price = -1
            if current_price > self.candles[-1][4]:
                self.direction_text = "▲"
            elif current_price < self.candles[-1][4]:
                self.direction_text = "▼"
            else:
                return
            self.candles[-1][4] = current_price
            series = [x[4] for x in self.candles]
            mean = self.get_average(series)
            stdev2 = self.get_stdev(series) * 2
            if current_price > mean + stdev2:
                self.background = "#859900"
            elif current_price < mean - stdev2:
                self.background = "#DC322F"
            else:
                self.background = '#073642'

            self.tick()

    def timer(self):
        while True:
            time.sleep(70)
            if self.message_received:
                self.message_received = False
            else:
                self.close()
                self.direction_text = "-"
                self.candles = None
                self.start()
                break

    def start(self):
        self.exception = None
        threading.Thread(target=self.timer).start()
        try:
            self.candles = ccxt.bitmex().fetchOHLCV("BTC/USD", '1m', (calendar.timegm(time.gmtime()) - 19 * 60) * 1000, 19)
            self.XBTUSD.run_forever()
        except Exception as e:
            self.exception = e
            file = open('/home/leon/scripts/bitmexWidget.log', 'a')
            file.write(str(self.exception))
            file.close()
            self.tick()

    def close(self):
        self.XBTUSD.close()
        self.exception = ''
        self.tick()

    def __init__(self, num_of_decimals=1, **config):
        base.InLoopPollText.__init__(self, "sample text", **config)
        self.update_interval = 1000000
        self.exception = None

        self.num_of_decimals = num_of_decimals
        self.direction_text = "-"
        self.candles = []
        self.message_received = False
        channels = [
            InstrumentChannels.tradeBin1m,
            InstrumentChannels.trade,
        ]
        self.XBTUSD = Instrument(symbol='XBTUSD', channels=channels)
        self.XBTUSD.on('action', self.on_message)
        websocket.enableTrace(True)

        threading.Thread(target=self.start).start()

    def poll(self):
        if self.exception is not None:
            return str(self.exception)
        if self.candles and self.candles[-1] and self.candles[-1][4]:
            price = self.candles[-1][4]
        else:
            price = 0
        return self.direction_text + ' ' + f"{price:.{self.num_of_decimals}f}"

