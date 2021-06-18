{ pkgs, config, ... }:
let
  weechat = pkgs.weechat.override {
    configure = { availablePlugins, ... }: with pkgs.weechatScripts;
      {
        scripts = [
          wee-slack
          weechat-matrix
        ];
        # plugins = [
        #   # the dependencies are propagated here
        #   (availablePlugins.python.withPackages (_: [ weechat-matrix ]))
        # ];
      };
  };
in
{
  # home.file.".weechat/python/autoload/notify_send.py".source = 
  #   "${(import ../../nix/sources.nix).weechat-notify-send}/notify_send.py";

  # home.file.".weechat/plugins.conf".text = ''
  #   [var]
  #   python.slack.auto_open_threads = "true"
  #   python.slack.background_load_all_history = "true"
  #   python.slack.channel_name_typing_indicator = "true"
  #   python.slack.color_buflist_muted_channels = "darkgray"
  #   python.slack.color_edited_suffix = "095"
  #   python.slack.color_reaction_suffix = "darkgray"
  #   python.slack.color_thread_suffix = "lightcyan"
  #   python.slack.colorize_private_chats = "false"
  #   python.slack.debug_level = "3"
  #   python.slack.debug_mode = "false"
  #   python.slack.distracting_channels = ""
  #   python.slack.external_user_suffix = "*"
  #   python.slack.group_name_prefix = "&"
  #   python.slack.map_underline_to = "_"
  #   python.slack.migrated = "true"
  #   python.slack.muted_channels_activity = "personal_highlights"
  #   python.slack.never_away = "false"
  #   python.slack.notify_usergroup_handle_updated = "false"
  #   python.slack.record_events = "false"
  #   python.slack.render_bold_as = "bold"
  #   python.slack.render_italic_as = "italic"
  #   python.slack.send_typing_notice = "true"
  #   python.slack.server_aliases = ""
  #   python.slack.shared_name_prefix = "%"
  #   python.slack.short_buffer_names = "false"
  #   python.slack.show_buflist_presence = "true"
  #   python.slack.show_reaction_nicks = "true"
  #   python.slack.slack_timeout = "20000"
  #   python.slack.switch_buffer_on_join = "true"
  #   python.slack.thread_messages_in_channel = "false"
  #   python.slack.unfurl_auto_link_display = "both"
  #   python.slack.unfurl_ignore_alt_text = "false"
  #   python.slack.unhide_buffers_with_activity = "false"
  # '';
  # python.slack.slack_api_token = "${config.secrets.slack-term}"

  # home.packages = [ weechat ];
}
