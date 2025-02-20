# https://gnome.pages.gitlab.gnome.org/nautilus-python/
# Inspired by: https://github.com/ngntrpy/nautilus-open-tmux

# XXX: Prints a lot of "no server running ..." messages if there are no tmux sessions.

import subprocess
from urllib.parse import unquote
from gi.repository import Nautilus, GObject


def tmux_sessions() -> list[str]:
    """
    Returns a list of all running tmux sessions, an empty list if there are none.
    """
    try:
        sessions = subprocess.check_output(["tmux", "ls"]).decode().splitlines()
        return list(map(lambda x: x[: x.find(":")], sessions))
    except subprocess.CalledProcessError:
        return []


class TmuxAttachProvider(GObject.GObject, Nautilus.MenuProvider):
    def _tmux_attach(
        self, menu: Nautilus.MenuItem, location: Nautilus.FileInfo, session: str
    ) -> None:
        filename = unquote(location.get_uri()[7:])
        # Setting the (-t)arget in "session:window" format.
        # https://unix.stackexchange.com/questions/515935/tmux-how-to-specify-session-in-new-window
        subprocess.Popen(["tmux", "new-window", "-t", f"{session}:", "-c", filename])

    def _add_sessions(self, submenu: Nautilus.Menu, target: Nautilus.FileInfo) -> None:
        """
        Adds an item to launch the target in a new window for every available tmux session to the submenu.
        """
        sessions = tmux_sessions()
        if not sessions:
            no_sessions_item = Nautilus.MenuItem(
                name=f"TmuxAttachProvider::no_sessions",
                label="No tmux sessions available",
                sensitive=False,
            )
            submenu.append_item(no_sessions_item)

        for session in tmux_sessions():
            submenu_item = Nautilus.MenuItem(
                name=f"TmuxAttachProvider::{session}",
                label=session,
            )
            submenu_item.connect("activate", self._tmux_attach, target, session)
            submenu.append_item(submenu_item)

    def get_file_items(
        self,
        files: list[Nautilus.FileInfo],
    ) -> list[Nautilus.MenuItem]:
        if len(files) != 1:
            return
        file = files[0]
        if not file.is_directory() or file.get_uri_scheme() != "file":
            return

        menu_item = Nautilus.MenuItem(
            name="TmuxAttachProvider::open_file",
            label="tmux",
        )
        submenu = Nautilus.Menu()
        menu_item.set_submenu(submenu)
        self._add_sessions(submenu, file)
        return [
            menu_item,
        ]

    def get_background_items(
        self,
        current_folder: Nautilus.FileInfo,
    ) -> list[Nautilus.MenuItem]:
        menu_item = Nautilus.MenuItem(
            name="TmuxAttachProvider::open_background",
            label="tmux",
        )
        submenu = Nautilus.Menu()
        menu_item.set_submenu(submenu)
        self._add_sessions(submenu, current_folder)
        return [
            menu_item,
        ]
