# frozen_string_literal: true

require "spec_helper"

describe "Show a jitsi_meeting", type: :system do
  include_context "with a component"
  let(:manifest_name) { "jitsi_meetings" }

  let(:api) do
    {
      "en" => "https://meet.jit.si/external_api.js",
      "ca" => "https://meet.jit.si/external_api.js",
      "es" => "https://meet.jit.si/external_api.js"
    }
  end

  let(:domain) do
    {
      "en" => "meet.jit.si",
      "ca" => "meet.jit.si",
      "es" => "meet.jit.si"
    }
  end

  let(:room_name) do
    {
      "en" => "Module-Jitsi-Meetings",
      "ca" => "Module-Jitsi-Meetings",
      "es" => "Module-Jitsi-Meetings"
    }
  end

  let!(:jitsi_meeting_component) { create(:jitsi_meeting, component: component, api: api, domain: domain, room_name: room_name) }

  describe "jitsi_meeting show" do
    before do
      visit_component
    end

    it_behaves_like "editable content for admins"

    it "renders the content of the jitsi_meeting" do
      expect(jitsi_meeting).to have_content("Content")
    end
  end
end