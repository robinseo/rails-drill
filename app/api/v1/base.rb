class V1::Base < Grape::API
  include V1Error::Handler

  version "v1", using: :path
  helpers PaginationHelper

  mount V1::Room
end