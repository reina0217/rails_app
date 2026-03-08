module BootstrapHelper
  ALERT_TYPES = %w[danger info success warning].freeze unless const_defined?(:ALERT_TYPES)

  def bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      next if message.blank?
      type = 'success' if type == 'notice'
      type = 'danger'  if %w[alert error].include?(type)
      next unless ALERT_TYPES.include?(type)
      add_message(type, message, flash_messages)
    end
    safe_join(flash_messages, "\n")
  end

  private

  def add_message(type, message, flash_messages)
    Array(message).each do |msg|
      next unless msg
      text = tag.div(class: "alert alert-dismissible fade show alert-#{type} mb-1") do
        concat tag.button(raw('&times;'), class: 'close', data: { dismiss: 'alert' })
        concat msg
      end
      flash_messages << text
    end
  end
end
