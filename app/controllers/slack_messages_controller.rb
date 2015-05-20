class SlackMessagesController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :require_login

  def create
    if params[:token] !=  ENV['SLACK_TOKEN']
      head 401
      return
    end

    url = clean_slack_formatting(params[:text][params[:trigger_word].size..-1])
    link_params = {
      link: {
        url: url,
        description: 'From Slack'
      },
      user_email: params[:user_name]
    }

    run Link::Create, link_params do |op|
      @new_link = op.model
      render json: { text: "#{root_url}#{@new_link.unique_key}, from #{@new_link.url}" }
      return
    end

    head 422
  end

  private

  def clean_slack_formatting(url)
    url.match(/\s<([^|]+)|/)[1] || url
  end
end
