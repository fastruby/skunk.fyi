class GithubController < ApplicationController
  protect_from_forgery

  def show
    begin

      @project = Project.find_by!(permalink: params[:id])

    rescue
      redirect_to new_github_path(source: "github", permalink: params[:id])
    end
  end

  def new
    @permalink = params[:permalink]
    @source = params[:source]
    @git_url = "git@#{@source}.com:#{@permalink}.git"

    @project = Project.new(permalink: @permalink, git_url: @git_url)
  end
end
