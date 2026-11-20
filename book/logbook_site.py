"""Point the Log book download menu at the logbook site.

sphinx-typst-render adds each log book entry to the page's download menu as a
PDF built here. Students now fill in their entry on the logbook site
(https://nb-tudelft.github.io/EI_Logbooks/), which copies the entries from
this repository. This extension changes the menu, after the renderer has
built it:

* "Entry X.Y" opens the entry on the site (``?logbook=X.Y``).
* "Entry X.Y (source)" stays as it is: the ``.typ`` file.
* "Entry X.Y" plus ``logbook_site_printable_suffix`` is added: the empty
  fillable PDF from the site, for students with their own PDF workflow.

Config, in ``sphinx.config`` of ``_config.yml``:

* ``logbook_site_url``: the site's address, ending in ``/``.
* ``logbook_site_printable_suffix``: what follows "Entry X.Y" on the PDF item.
"""
import re

#: sphinx-typst-render marks its menu items with this button label.
OURS = "typst-download"
#: A rendered entry: <week>.<manual>_<name>_logbook.pdf
ENTRY = re.compile(r"(?:^|/)((\d+\.\d+)_[^/]+_logbook)\.pdf$")


def relink(app, pagename, templatename, context, doctree):
    site = app.config.logbook_site_url
    suffix = app.config.logbook_site_printable_suffix
    for group in context.get("header_buttons", []):
        if group.get("type") != "group":
            continue
        buttons, printable = [], []
        for button in group.get("buttons", []):
            match = button.get("label") == OURS and ENTRY.search(button.get("url", ""))
            if not match:
                buttons.append(button)
                continue
            stem, number = match.groups()
            buttons.append({**button, "url": f"{site}?logbook={number}",
                            "icon": "fas fa-pen-to-square"})
            text = button.get("text", stem) + suffix
            printable.append({**button, "url": f"{site}logbooks/{stem}.pdf",
                              "text": text, "tooltip": text})
        group["buttons"] = buttons + printable


def setup(app):
    app.add_config_value("logbook_site_url", "https://nb-tudelft.github.io/EI_Logbooks/", "html")
    app.add_config_value("logbook_site_printable_suffix", " (printable)", "html")
    # The renderer adds its items at priority 600; change them after that.
    app.connect("html-page-context", relink, priority=601)
    return {"parallel_read_safe": True, "parallel_write_safe": True}
