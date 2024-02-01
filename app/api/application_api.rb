class ApplicationAPI < Grape::API
  format :json
  prefix 'api'

  mount V1::Base
end
