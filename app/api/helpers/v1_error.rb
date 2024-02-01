module V1Error
  class BaseError < StandardError
    attr_reader :status, :error_code, :message, :detail

    def initialize(status:, error_code:, message:, detail: nil)
      @status = status
      @error_code = error_code
      @message = message
      @detail = detail
      super(detail || message)
    end
  end

  class InvalidToken < BaseError; end

  class InvalidPassword < BaseError; end

  class Unauthorized < BaseError; end

  class ArgumentError < BaseError; end

  EXCEPTIONS = {
    #= 400
    ActiveRecord::RecordInvalid => { status: 400, error_code: 40001, message: "Invalid Request" },

    #= 401
    InvalidToken => { status: 401, error_code: 40101, message: "Invalid token" },
    InvalidPassword => { status: 401, error_code: 40102, message: "Invalid password" },

    #= 403
    Unauthorized => { status: 403, error_code: 40301, message: "This admin account does not allowed for this operation" },

    #= 404
    ActiveRecord::RecordNotFound => { status: 404, error_code: 40401, message: "Cannot find resource" },
  }

  module Handler
    def self.included(klass)
      klass.class_eval do
        EXCEPTIONS.each do |exception_class, context|
          rescue_from exception_class do |exception|
            error_response = {
              error: context[:message],
              error_detail: (context[:detail] || exception.message),
              error_code: context[:error_code],
            }.compact
            error!(error_response, context[:status])
          end
        end
      end
    end
  end
end
