rule_rename_built_in_mic = {
  matches = {
    {
      { "node.name", "equals", "alsa_input.pci-0000_00_1f.3.analog-stereo" },
    },
  },
  apply_properties = {
    ["node.description"] = "built-in mic",
  },
}

rule_rename_built_in_speaker = {
  matches = {
    {
      { "node.name", "equals", "alsa_output.pci-0000_00_1f.3.analog-stereo" },
    },
  },
  apply_properties = {
    ["node.description"] = "built-in speaker",
  },
}

table.insert(alsa_monitor.rules, rule_rename_built_in_mic)
table.insert(alsa_monitor.rules, rule_rename_built_in_speaker)
