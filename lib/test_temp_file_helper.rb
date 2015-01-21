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

require "test_temp_file_helper/version"

module TestTempFileHelper
  # Automatically generates and cleans up temporary files in automated tests.
  #
  # The temporary directory containing all generated files and directories is
  # set by the first of these items which is not +nil+:
  # - the +tmp_dir+ argument to +TempFileHelper.new+
  # - the +TEST_TMPDIR+ environment variable
  # - +Dir.mktmpdir+
  class TempFileHelper
    attr_accessor :tmpdir

    # @param tmpdir [String] (optional) if set, determines the temp dir
    def initialize(tmp_dir: nil)
      @tmpdir = tmp_dir || ENV['TEST_TMPDIR'] || Dir.mktmpdir
    end

    # Creates a temporary test directory relative to TEST_TMPDIR.
    # @param relative_path [String] directory to create
    # @return [String] File.join(@tmpdir, relative_path)
    def mkdir(relative_path)
      new_dir = File.join @tmpdir, relative_path
      FileUtils.mkdir_p new_dir
      new_dir
    end

    # Creates a temporary file relative to TEST_TMPDIR.
    # @param relative_path [String] file to create
    # @param content [String] (optional) content to include in the file
    # @return [String] File.join(@tmpdir, relative_path)
    def mkfile(relative_path, content: '')
      mkdir File.dirname(relative_path)
      filename = File.join(@tmpdir, relative_path)
      File.open(filename, 'w') {|f| f << content}
      filename
    end

    # Removes all files and directories created by the instance. Should be
    # called from the test's +teardown+ method.
    def teardown
      FileUtils.remove_entry @tmpdir
    end
  end
end
