# test_temp_file_helper - Generates and cleans up temp files for automated tests
#
# Written in 2015 by Mike Bland (michael.bland@gsa.gov)
# on behalf of the 18F team, part of the US General Services Administration:
# https://18f.gsa.gov/
#
# To the extent possible under law, the author(s) have dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.
#
# You should have received a copy of the CC0 Public Domain Dedication along
# with this software. If not, see
# <https://creativecommons.org/publicdomain/zero/1.0/>.
#
# @author Mike Bland (michael.bland@gsa.gov)

require 'rake/tasklib'

module TestTempFileHelper

  # A Rake task that sets up the +TEST_DATADIR+ and +TEST_TMPDIR+ environment
  # variables.
  #
  # Properties:
  # - +base_dir+: parent directory used to set the environment variables
  # - +data_dir+: directory relative to +base_dir+ used to set +TEST_DATADIR+
  # - +tmp_dir+: directory relative to +base_dir+ used to set +TEST_TMPDIR+
  #
  # If an environment variable is already set, or if the corresponding
  # property is not set on the +SetupTestEnvironmentTask+ object, the
  # environment variable will not be set or updated.
  #
  # Usage (inside a +Rakefile+):
  #
  # require 'test_temp_file_helper/rake'
  #
  # TestTempFileHelper::SetupTestEnvironmentTask.new do |t|
  #   t.base_dir = File.dirname __FILE__
  #   t.data_dir = File.join('test', 'data')
  #   t.tmp_dir = File.join('test', 'tmp')
  # end
  class SetupTestEnvironmentTask < ::Rake::TaskLib
    def initialize(name='test_temp_file_helper_setup_test_environment')
      @name = name
      @base_dir = nil
      yield self if block_given?

      set_environment_variable 'TEST_DATADIR', @data_dir
      set_environment_variable 'TEST_TMPDIR', @tmp_dir
      test_tmpdir = ENV['TEST_TMPDIR']

      if test_tmpdir
        rm_rf test_tmpdir if File.exists? test_tmpdir
        directory test_tmpdir
        task test: test_tmpdir
      end
    end

    # Sets +ENV[var_name]+ as the concatenation of +base_dir+ and
    # +relative_dir+.
    # @param var_name [String]
    # @param relative_dir [String]
    def set_environment_variable(var_name, relative_dir)
      unless ENV[var_name]
        ENV[var_name] = File.join @base_dir, relative_dir if relative_dir
      end
    end
    private :set_environment_variable

    # Sets the base directory that serves as the common parent for the
    # +TEST_DATADIR+ and +TEST_TMPDIR+ environment variables.
    # @param dirname [String] parent dir of +data_dir+ and +tmp_dir+
    def base_dir=(dirname)
      @base_dir = dirname
    end

    # Sets +TEST_DATADIR+ using a path relative to the +base_dir+.
    # @param dirname [String] path relative to +base_dir+
    def data_dir=(dirname)
      @data_dir = dirname
    end

    # Sets +TEST_TMPDIR+ using a path relative to the +base_dir+.
    # @param dirname [String] path relative to +base_dir+
    def tmp_dir=(dirname)
      @tmp_dir = dirname
    end
  end
end
