require 'slack-ruby-client'

class StatusChanger
  attr_accessor :client

  def initialize
    @token = ENV['slack_token']
    @client = Slack::Web::Client.new(token: @token)
    @user = @client.auth_test.user_id
  end

  def change(from: nil, to:)
    if  case from
        when String
          current[:text] == from
        when Regexp
          current[:text].match from
        when Symbol
          current[:emoji] == from
        when nil
          true
        end
      set(to)
    end
  end

  def clear
    set
  end

  def current
    profile = @client.get('users.profile.get').profile
    text = profile.fetch :status_text
    emoji = profile.fetch(:status_emoji).delete(':').to_sym
    {text: text, emoji: emoji}
  end

  def set(text: nil, emoji: nil)
    profile = { status_text: text, status_emoji: emoji_id(emoji) }.to_json
    @client.post('users.profile.set', profile: profile)
  end

  private

  def emoji_id(emoji)
    case emoji
    when /:[a-z_]+:/
      emoji
    when nil, ''
      ''
    else
      ":#{emoji}:"
    end
  end
end
