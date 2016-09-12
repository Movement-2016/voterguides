class GuideReportsController < ApplicationController
  before_action :require_guide

  def new
    @guide_report = @voter_guide.guide_reports.build
  end

  def create
    @guide_report = @voter_guide.guide_reports.build(guide_report_params)
    @guide_report.reporter = current_user
    if @guide_report.save
      GuidesReportingMailer.report_guide(@guide_report.id).deliver_now
      redirect_to voter_guide_path(@voter_guide), notice: 'Thanks for reporting! We\'ll read it as soon as we can'
    else
      render :new
    end
  end

  private

  def require_guide
    @voter_guide = VoterGuide.find_by_secure_id!(params[:voter_guide_id])
  end

  def guide_report_params
    params.require(:guide_report).permit(:body)
  end
end
