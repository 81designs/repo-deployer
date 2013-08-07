class ReposController < ApplicationController
  include GithubAccessible
  before_action :authenticate_user!, except: [:index, :github_hook]
  before_action :set_repo, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session, only: [:github_hook]

  def index
    @repos = Repo.all
  end
  
  def update
    if @repo.update(repo_params)
      redirect_to :back, notice: 'Settings updated successfully.'
    else
      redirect_to :back, alert: 'Settings could not be saved.'
    end
  end

  def destroy
    @repo.destroy
    respond_to do |format|
      format.html { redirect_to repos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_repo
      @repo = Repo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def repo_params
      params.require(:repo).permit(:test_commands, :test_setup_commands)
    end
end
