from ranger.api.commands import Command

class paste_as_root(Command):
	def execute(self):
		if self.fm.do_cut:
			self.fm.execute_console('shell sudo mv %c .')
		else:
			self.fm.execute_console('shell sudo cp -r %c .')

class fzf_select(Command):
    """
    :fzf_select

    Find a file using fzf.

    With a prefix argument select only directories.

    See: https://github.com/junegunn/fzf
    """
    def execute(self):
        import subprocess
        import os.path
        if self.quantifier:
            # match only directories
            command="find -L . \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) -prune \
            -o -type d -print 2> /dev/null | sed 1d | cut -b3- | fzf +m --reverse --header='Jump to file'"
        else:
            # match files and directories
            command="find -L . \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) -prune \
            -o -print 2> /dev/null | sed 1d | cut -b3- | fzf +m --reverse --header='Jump to filemap <C-f> fzf_select'"
        fzf = self.fm.execute_command(command, universal_newlines=True, stdout=subprocess.PIPE)
        stdout, stderr = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.rstrip('\n'))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)

class new_cargo_lib(Command):
    def execute(self):
        import os
        import subprocess
        import threading
        arg1 = self.rest(1)
        subprocess.Popen(['/home/stock/data/linux/scripts/new_cargo_lib.sh', f'{arg1}'], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL).wait()
        # a = self.fm.ui.__dir__()
        # f = open("/tmp/ranger", "a")
        # f.write(str(a))
        # subprocess.Popen(['notify-send', f'"{a}"'], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL).wait()
        self.fm.ui.initialize()
        cwd = str(self.fm.thisdir) + f"/{arg1}/src/"
        self.fm.cd(cwd)
        # doesn't work: ui needs to update before the file can be opened
        self.fm.move(right=1)
        # def other(fm):
        #     import time
        #     time.sleep(1)
        #     # self.fm.select_file(f'{arg1}.rs')
        #     # self.fm.move(right=1)
        #     fm.execute_console('move right=1')
        # threading.Thread(target=other, args=(self.fm,)).start()

class new_cargo_bin(Command):
    def execute(self):
        import os
        import subprocess
        arg1 = self.rest(1)
        subprocess.Popen(['/home/stock/data/linux/scripts/new_cargo_bin.sh', f'{arg1}'], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL).wait()
        cwd = self.fm.thisdir.path + f"/{arg1}/src/"
        self.fm.cd(cwd)
        self.fm.select_file(f'{arg1}.rs')
        self.fm.execute_console('move right=1')
