# frozen_string_literal: true

require_dependency "decidim/components/namer"

Decidim.register_component(:jitsi_meetings) do |component|
  component.engine = Decidim::JitsiMeetings::Engine
  component.admin_engine = Decidim::JitsiMeetings::AdminEngine
  component.icon = "decidim/jitsi_meetings/icon.svg"
  component.permissions_class_name = "Decidim::JitsiMeetings::Permissions"

  component.query_type = "Decidim::JitsiMeetings::JitsiMeetingsType"

  component.on(:create) do |instance|
    Decidim::JitsiMeetings::CreateJitsiMeeting.call(instance) do
      on(:invalid) { raise "Can't create jitsi meeting" }
    end
  end

  component.on(:destroy) do |instance|
    Decidim::JitsiMeetings::DestroyJitsiMeeting.call(instance) do
      on(:error) { raise "Can't destroy jitsi meeting" }
    end
  end

  component.on(:copy) do |context|
    Decidim::JitsiMeetings::CopyJitsiMeeting.call(context) do
      on(:invalid) { raise "Can't duplicate jitsi meeting" }
    end
  end

  component.settings(:global) do |settings|
    settings.attribute :announcement, type: :text, translated: true, editor: true
  end

  component.settings(:step) do |settings|
    settings.attribute :announcement, type: :text, translated: true, editor: true
  end

  component.register_resource(:jitsi_meeting) do |resource|
    resource.model_class_name = "Decidim::JitsiMeetings::JitsiMeeting"
  end

  # component.on(:before_destroy) do |instance|
  #   # Code executed before removing the component
  # end

  # These actions permissions can be configured in the admin panel
  # component.actions = %w()

  # component.settings(:global) do |settings|
  #   # Add your global settings
  #   # Available types: :integer, :boolean
  #   # settings.attribute :vote_limit, type: :integer, default: 0
  # end

  # component.settings(:step) do |settings|
  #   # Add your settings per step
  # end

  # component.register_resource(:some_resource) do |resource|
  #   # Register a optional resource that can be references from other resources.
  #   resource.model_class_name = "Decidim::JitsiMeetings::SomeResource"
  #   resource.template = "decidim/jitsi_meetings/some_resources/linked_some_resources"
  # end

  # component.register_stat :some_stat do |context, start_at, end_at|
  #   # Register some stat number to the application
  # end

  # component.seeds do |participatory_space|
  #   # Add some seeds for this component
  # end
end
