from docutils import nodes
from docutils.parsers.rst import directives as rst_directives
from docutils.parsers.rst.directives import admonitions


NO_CONTENT_CLASSES = {
    "no-content",
    "no_content",
    "admonition-no-content",
    "admonition-no_content",
}


class EstimatedTimeAdmonition(admonitions.Admonition):
    """Allow empty generic admonitions when explicitly marked as contentless."""

    def run(self):
        admonitions.set_classes(self.options)
        classes = set(self.options.get("classes", []))
        if self.content or not (classes & NO_CONTENT_CLASSES):
            return super().run()

        admonition_node = self.node_class("", **self.options)
        self.add_name(admonition_node)
        admonition_node.source, admonition_node.line = (
            self.state_machine.get_source_and_line(self.lineno)
        )

        title_text = self.arguments[0]
        textnodes, messages = self.state.inline_text(title_text, self.lineno)
        title = nodes.title(title_text, "", *textnodes)
        title.source, title.line = self.state_machine.get_source_and_line(self.lineno)

        admonition_node += title
        admonition_node += messages
        return [admonition_node]


def setup(app):
    rst_directives.register_directive("admonition", EstimatedTimeAdmonition)
    return {
        "parallel_read_safe": True,
        "parallel_write_safe": True,
    }
