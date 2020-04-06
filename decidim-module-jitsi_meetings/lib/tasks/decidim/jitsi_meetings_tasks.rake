# frozen_string_literal: true

namespace :decidim_jitsi_meetings do
  desc "Install decidim-jitsi_meetings migrations"
  task upgrade: [:choose_target_plugin, :"railties:install:migrations"]

  desc "Setup environment so that only decidim-jitsi_meetings migrations are installed"
  task :choose_target_plugin do
    ENV["FROM"] = "decidim_jitsi_meetings"
  end
end