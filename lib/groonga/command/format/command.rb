# -*- coding: utf-8 -*-
#
# Copyright (C) 2012-2013  Kouhei Sutou <kou@clear-code.com>
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

require "English"

module Groonga
  module Command
    module Format
      class Command
        class << self
          def escape_value(value)
            escaped_value = value.gsub(/[\n"\\]/) do
              special_character = $MATCH
              case special_character
              when "\n"
                "\\n"
              else
                "\\#{special_character}"
              end
            end
            "\"#{escaped_value}\""
          end
        end

        def initialize(name, arguments)
          @name = name
          @arguments = arguments
        end

        def command_line
          components = [@name]
          sorted_arguments = @arguments.sort_by do |name, _|
            name.to_s
          end
          sorted_arguments.each do |name, value|
            components << "--#{name}"
            components << self.class.escape_value(value)
          end
          components.join(" ")
        end
      end
    end
  end
end
