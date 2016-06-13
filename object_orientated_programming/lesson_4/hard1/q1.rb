class SecretFile

  def initialize(secret_data)
    @data = secret_data
    @secutity_logger = SecurityLogger.new
  end

  def data
    @secutity_logger.create_log_entry
    @data
end

class SecurityLogger
  def create_log_entry
    # ... implementation omitted ...
  end
end