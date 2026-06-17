{
  inputs,
  den,
  ...
}: {
  # Create "my" namespace (exported to flake outputs)
  imports = [(inputs.den.namespace "normal" true)];
  _module.args.__findFile = den.lib.__findFile;
}
