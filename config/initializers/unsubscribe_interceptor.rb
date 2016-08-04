class UnsubscribeInterceptor
  def self.delivering_email(message)
    if UnsubscribeOption.where(email: message.to).where.not(requested_at: nil).any?
      message.perform_deliveries = false
    end
  end
end

ActionMailer::Base.register_interceptor(UnsubscribeInterceptor)
