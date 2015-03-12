begin
  require 'hammer_cli_katello'

  module HammerCLIForemanDocker
    class DockerImageCommand < HammerCLIForeman::Command
      resource :docker_images
      command_name 'image'
      desc _('Manage docker images')

      class ListCommand < HammerCLIKatello::ListCommand
        include ::HammerCLIKatello::LifecycleEnvironmentNameResolvable
        output do
          field :id, _("ID")
          field :image_id, _("Image ID")
          field :size, _("Size")
        end

        build_options do |o|
          o.expand.including(:products, :organizations, :content_views)
        end
      end

      class InfoCommand < HammerCLIKatello::InfoCommand
        output do
          field :id, _("ID")
          field :image_id, _("Image ID")
          field :size, _("Size")

          collection :tags, _("Tags") do
            field :repository_id, _("Repository ID")
            field :tag, _("Tag")
          end
        end

        build_options
      end

      autoload_subcommands
    end
  end
rescue LoadError
  warn _("'hammer_cli_katello' needs to be installed for %s command to work") % 'image'
end
