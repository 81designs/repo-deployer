class BuildsController < ApplicationController
  before_action :authenticate_user!, except: [:create]
  before_action :set_build, only: [:show, :edit, :update, :destroy]
  before_action :set_repo, only: [:index, :show, :edit, :update, :destroy]

  # GET /builds
  # GET /builds.json
  def index
    @builds = @repo.builds.order('created_at DESC')
  end

  # GET /builds/1
  # GET /builds/1.json
  def show
  end

  # DELETE /builds/1
  # DELETE /builds/1.json
  def destroy
    @build.destroy
    respond_to do |format|
      format.html { redirect_to builds_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_build
      @build = Build.find(params[:id])
    end
    
    def set_repo
      @repo = Repo.find(params[:repo_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def build_params
      params.require(:build).permit(:repo_id, :status)
    end
end
