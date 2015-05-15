require 'httparty'
require 'active_support/all'
require 'gnuplot'
require 'yaml'

class Pressure
  def initialize
    config = YAML.load_file './config/conf.yml'
    @current =  "https://api.forecast.io/forecast/#{config['api_key']}/#{config['lat']},#{config['long']}"
  end

  def plot_pressures
    pressures = plot_urls.map { |url| get_pressure response_hash(url) }

    Gnuplot.open do |gp|
      Gnuplot::Plot.new(gp) do |plot|
        plot.terminal 'png'
        plot.output File.expand_path('../pressure.png', __FILE__)

        plot.title 'Pressure'
        plot.xlabel 'Time'
        plot.ylabel 'Millibars'

        plot.data << Gnuplot::DataSet.new([(-4..4).to_a, pressures]) do |ds|
          ds.with = 'linespoints'
          ds.notitle
        end
      end
    end
  end

  def plot_urls
    past_urls = (1..4).to_a.reverse.map { |h| append_time @current, h.hours.ago }
    future_urls = (1..4).map { |h| append_time @current, h.hours.from_now }

    past_urls.concat([@current]).concat(future_urls)
  end

  def response_hash(url)
    JSON.parse(HTTParty.get(url).body)
  end

  def get_pressure(hash)
    hash['currently']['pressure']
  end

  def append_time(url, time)
    url + ',' + format_time(time.to_s)
  end

  def format_time(time_str)
    time_str[10] = 'T'
    time_str.remove ' '
  end
end
