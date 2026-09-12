#!/usr/bin/env python3
"""Serve the built game locally; use --host 0.0.0.0 to test on your LAN."""
from pathlib import Path
from http.server import ThreadingHTTPServer,SimpleHTTPRequestHandler
from functools import partial
import argparse

ROOT=Path(__file__).resolve().parents[1]
class Handler(SimpleHTTPRequestHandler):
    extensions_map={**SimpleHTTPRequestHandler.extensions_map,'.wasm':'application/wasm','.js':'text/javascript'}
    def end_headers(self):
        self.send_header('Cache-Control','no-cache')
        super().end_headers()

def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--host',default='127.0.0.1')
    parser.add_argument('--port',type=int,default=8766)
    parser.add_argument('--directory',type=Path,help='Serve an unpacked static game directory.')
    args=parser.parse_args()
    web=args.directory.resolve() if args.directory else (ROOT if (ROOT/'index.html').is_file() else ROOT/'dist/web')
    if not (web/'index.html').is_file():raise SystemExit('Build first: python3 scripts/build_web.py')
    server=ThreadingHTTPServer((args.host,args.port),partial(Handler,directory=web))
    print(f'Findus: http://{args.host}:{args.port}/',flush=True)
    try:server.serve_forever()
    except KeyboardInterrupt:pass
    finally:server.server_close()

if __name__=='__main__':main()
