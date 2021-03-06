require "async"
require "async/barrier"
require "async/http/internet/instance"

class AsyncLoader < GraphQL::Batch::Loader
  def perform(urls)
    barrier = Async::Barrier.new
    internet = Async::HTTP::Internet.instance

    urls.each do |url|
      barrier.async do
        Console.logger.info "AsyncHttp#get: #{url}"
        body = JSON.parse(internet.get(url).read)
        fulfill(url, body)
        Console.logger.info "AsyncHttp#fulfill: #{url}"
      end
    end

    Console.logger.info "AsyncHttp#wait"
    barrier.wait
  end
end
