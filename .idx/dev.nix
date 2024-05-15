# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{ pkgs, ... }: {
  # Which nixpkgs channel to use.
  channel = "stable-23.11"; # or "unstable"
  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.php82
    pkgs.php82Packages.composer
    pkgs.symfony-cli
    pkgs.nodejs_20
  ];
  # Sets environment variables in the workspace
  env = {};
  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      "bmewburn.vscode-intelephense-client"
      "esbenp.prettier-vscode"
      "mblode.twig-language-2"
      "MehediDracula.php-namespace-resolver"
    ];
    # Enable previews
    previews = {
      enable = true;
      previews = {
        web = {
          command = ["symfony" "local:server:start" "--port" "$PORT"];
          manager = "web";
        };
      };
    };
    # Workspace lifecycle hooks
    workspace = {
      # Runs when a workspace is first created
      onCreate = {
        symfony-install = "symfony new --webapp --dir=_symfony && rm -rf _symfony/.git && cp -R _symfony/. . && rm -rf _symfony";
      };
      onStart = {
        # Example: start a background task to watch and re-build backend code
        # watch-backend = "npm run watch-backend";
      };
    };
  };
  services = {
    docker = {
      enable = true;
    };
  };
}
