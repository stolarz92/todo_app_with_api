class PagedWithAllPaginator < PagedPaginator
  def apply(relation, _order_options)
    return relation.all if return_all?(@size)
    super
  end

  def links_page_params(options = {})
    return {} if return_all?(@size)
    super
  end

  def calculate_page_count(record_count)
    return 1 if return_all?(@size)
    super
  end

  private

  def parse_pagination_params(params)
    if params.nil?
      @number = 1
      @size = JSONAPI.configuration.default_page_size
    elsif params.is_a?(ActionController::Parameters)
      validparams = params.permit(:number, :size)
      if return_all?(validparams[:size])
        @size = 'all'
      else
        @size = validparams[:size] ? validparams[:size].to_i : JSONAPI.configuration.default_page_size
      end
      @number = validparams[:number] ? validparams[:number].to_i : 1
    else
      @size = JSONAPI.configuration.default_page_size
      @number = params.to_i
    end
  rescue ActionController::UnpermittedParameters => e
    raise JSONAPI::Exceptions::PageParametersNotAllowed.new(e.params)
  end

  def verify_pagination_params
    return if return_all?(@size)
    super
  end

  def return_all?(size)
    size == 'all'
  end
end