# Pressure

Sinatra app to generate and serve pressure charts for a given location.  
Uses the [Dark Sky Forecast API](https://developer.forecast.io/) to retrieve pressure data and forecasts for a given location and plots them with [GnuPlot](http://www.gnuplot.info/), via [ruby_gnuplot](https://github.com/rdp/ruby_gnuplot).
Plots are updated every hour with [Rake](https://github.com/ruby/rake) and [Whenever](https://github.com/javan/whenever).

##How-To

* Get an API key at https://developer.forecast.io/
* Add your key, latitude, and longitude to `config/conf.yml`
* Install GnuPlot
  * If you have Homebrew or Aptitude installed, run `brew install gnuplot` or `sudo apt-get install gnuplot`
  * Otherwise, binaries can be found at http://www.gnuplot.info/
* Install gems with `bundle install`
* Register the Cron job to generate plots hourly with `whenever --write-crontab`
* Serve the app however you see fit; the default endpoint is `/pressure`
  * You can test locally at http://localhost:4567/pressure with `ruby server.rb`

#####Copyright (C) 2015  Zachary Price

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
