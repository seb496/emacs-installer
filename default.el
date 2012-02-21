; Starting server so that the context menu entry can connect to it.
(require 'server)
(or (server-running-p)
    (server-start))
