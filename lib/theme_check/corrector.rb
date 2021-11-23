# frozen_string_literal: true

module ThemeCheck
  class Corrector
    include JsonHelpers

    def initialize(theme_file:)
      @theme_file = theme_file
    end

    def insert_after(node, content)
      @theme_file.rewriter.insert_after(node, content)
    end

    def insert_before(node, content)
      @theme_file.rewriter.insert_before(node, content)
    end

    def remove(node)
      @theme_file.rewriter.remove(node)
    end

    def replace(node, content)
      @theme_file.rewriter.replace(node, content)
      node.markup = content
    end

    def replace_inner_markup(node, content)
      @theme_file.rewriter.replace_inner_markup(node, content)
    end

    def replace_inner_json(node, json)
      replace_inner_markup(node, pretty_json(json))
    end

    def wrap(node, insert_before, insert_after)
      @theme_file.rewriter.wrap(node, insert_before, insert_after)
    end

    def create_file(storage, relative_path, content)
      storage.write(relative_path, content)
    end

    def remove_file(storage, relative_path)
      storage.remove(relative_path)
    end

    def mkdir(storage, relative_path)
      storage.mkdir(relative_path)
    end

    def add_translation(json_file, path, value)
      hash = json_file.content
      SchemaHelper.set(hash, path, value)
      json_file.update_contents(hash)
    end
  end
end
