class AnnouncementsController < DocumentsController
  enable_request_formats index: %i[json atom]

  def index
    expire_on_next_scheduled_publication(scheduled_announcements)
    @filter = build_document_filter("announcements")
    @filter.announcements_search
    presenter = AnnouncementPresenter if params[:locale].present?

    respond_to do |format|
      format.html do
        return redirect_to_news_and_communications if Locale.current.english?

        @content_item = Whitehall
          .content_store
          .content_item("/government/announcements")
          .to_hash

        @filter = AnnouncementFilterJsonPresenter.new(
          @filter, view_context, presenter
        )
      end
      format.json do
        render json: AnnouncementFilterJsonPresenter.new(
          @filter, view_context, presenter
        )
      end
      format.atom do
        return redirect_to_news_and_communications(".atom") if Locale.current.english?

        @announcements = @filter.documents
      end
    end
  end

private

  def scheduled_announcements
    Announcement.scheduled.order("scheduled_publication asc")
  end

  def redirect_to_news_and_communications(format = "")
    base_path = "#{Plek.new.website_root}/search/news-and-communications#{format}"
    redirect_to("#{base_path}?#{news_and_communications_query_string}")
  end

  def news_and_communications_query_string
    allowed_params = cleaned_document_filter_params
    {
      keywords: allowed_params['keywords'],
      level_one_taxon: allowed_params['taxons'].try(:first),
      level_two_taxon: allowed_params['subtaxons'].try(:first),
      people: filter_query_array(allowed_params['people']),
      organisations: filter_query_array(allowed_params['departments']),
      topical_events: filter_query_array(allowed_params['topical_events']),
      world_locations: filter_query_array(allowed_params['world_locations']),
      public_timestamp: {
        from: allowed_params['from_date'],
        to: allowed_params['to_date']
      }.compact.presence,
    }.compact.to_query
  end
end
