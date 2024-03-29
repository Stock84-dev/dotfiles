local augend = require("dial.augend")

require("dial.config").augends:register_group{
  default = {
    augend.integer.alias.hex,
    augend.integer.alias.decimal,
    augend.integer.alias.decimal_int,
    augend.integer.alias.octal,
    augend.integer.alias.binary,
    augend.date.alias["%Y/%m/%d"],
    augend.date.alias["%Y-%m-%d"],
    augend.date.alias["%d.%m.%Y"],
    augend.date.alias["%m/%d"],
    augend.date.alias["%H:%M"],
    -- augend.paren.alias.quote,
    --augend.paren.alias.brackets,
    -- augend.paren.alias.lua_str_literal,
    -- augend.paren.alias.rust_str_literal,
    augend.semver.alias.semver,
    augend.constant.alias.bool,
    --augend.constant.alias.alpha,
    --augend.constant.alias.Alpha,
    augend.hexcolor.new{
      case = "lower",
    },
    augend.constant.new{ elements = {"yes", "no"} },
    augend.constant.new{ elements = {"on", "off"} },
    augend.constant.new{ elements = {"enable", "disable"} },
    augend.constant.new{ elements = {"first", "last"} },
    augend.constant.new{ elements = {"before", "after"} },
    augend.constant.new{ elements = {"persistent", "ephemeral"} },
    augend.constant.new{ elements = {"internal", "external"} },
    augend.constant.new{ elements = {"ingress", "egress"} },
    augend.constant.new{ elements = {"allow", "deny"} },
    augend.constant.new{ elements = {"left", "right"} },

    augend.constant.new{ elements = {"Yes", "No"} },
    augend.constant.new{ elements = {"On", "Off"} },
    augend.constant.new{ elements = {"True", "False"} },
    augend.constant.new{ elements = {"Enable", "Disable"} },
    augend.constant.new{ elements = {"First", "Last"} },
    augend.constant.new{ elements = {"Before", "After"} },
    augend.constant.new{ elements = {"Persistent", "Ephemeral"} },
    augend.constant.new{ elements = {"Internal", "External"} },
    augend.constant.new{ elements = {"Ingress", "Egress"} },
    augend.constant.new{ elements = {"Allow", "Deny"} },
    augend.constant.new{ elements = {"All", "None"} },
    augend.constant.new{ elements = {"Left", "Right"} },

    -- augend.constant.new{ elements = {"const", "mut"} },
    augend.constant.new{ elements = {"Some", "None"} },
    augend.constant.new{ elements = {"Ok", "Err"} },
    augend.constant.new{ elements = {"ref", "mut"} },
  },
  typescript = {
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    augend.constant.new{ elements = {"let", "const"} },
  },
  visual = {
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    augend.date.alias["%Y/%m/%d"],
    augend.constant.alias.alpha,
    augend.constant.alias.Alpha,
  },
}
