# frozen_string_literal: true

require "spec_helper"

describe "Edit a jitsi_meeting", type: :system do
  include_context "when managing a component as an admin"
  let(:component) { create(:component, manifest_name: "jitsi_meetings", participatory_space: participatory_process) }
  let(:manifest_name) { "jitsi_meetings" }

  describe "admin jitsi_meeting" do
    before do
      create(:jitsi_meeting, component: component, api: api, domain: domain, room_name: room_name)
      visit_component_admin
    end

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

    it "updates the jitsi_meeting" do
      new_room_name = {
        en: "New-Module-Jitsi-Meetings",
        ca: "New-Module-Jitsi-Meetings",
        es: "New-Module-Jitsi-Meetings"
      }

      within "form.edit_jitsi_meeting" do
        fill_in_i18n_editor(:jitsi_meeting_room_name, "#jitsi_meeting-room_name-tabs", new_room_name)
        find("*[type=submit]").click
      end

      expect(jitsi_meeting).to have_admin_callout("successfully")

      visit_component

      expect(jitsi_meeting).to have_content("New body")
    end
  end

  describe "announcements" do
    before do
      create(:jitsi_meeting, component: component, body: body)
      visit_component_admin
    end

    it_behaves_like "manage announcements"
  end
end