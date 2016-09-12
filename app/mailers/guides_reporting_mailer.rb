class GuidesReportingMailer < ApplicationMailer
  layout false
  default from: FROM_ADDRESS

  def guide_created(voter_guide_id)
    @voter_guide = VoterGuide.find(voter_guide_id)
    mail(to: FROM_ADDRESS, subject: "New Voter Guide at #{SITE_HOST}: #{@voter_guide.name}")
  end

  def report_guide(guide_report_id)
    @guide_report = GuideReport.find(guide_report_id)
    @voter_guide = @guide_report.voter_guide
    mail(to: FROM_ADDRESS, subject: "A Guide on #{SITE_HOST} has been reported")
  end
end
