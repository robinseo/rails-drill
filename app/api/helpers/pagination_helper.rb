module PaginationHelper
  def paginate_info(object)
    OpenStruct.new({
                     current_page: object.current_page,
                     per: object.limit_value,
                     total_pages: object.total_pages,
                     total_items: object.total_count
                   })
  end
end