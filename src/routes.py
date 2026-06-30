from fastapi import APIRouter
from fastapi.responses import HTMLResponse
from fastapi.templating import Jinja2Templates
from fastapi.requests import Request
from pathlib import Path


BASE_DIR = Path(__file__).resolve().parent.parent

templates = Jinja2Templates(directory=str(BASE_DIR / "static" / "templates"))

router = APIRouter(prefix="/cafesia")


@router.get("/", response_class=HTMLResponse)
async def home(request: Request):
    return templates.TemplateResponse(
        request=request,
        name="cafesia_index.html",
    )


@router.get("/catalogo", response_class=HTMLResponse)
async def catalogo(request: Request):
    tab = request.query_params.get("tab", "menu")
    active_tab = tab if tab in ("menu", "plantas") else "menu"
    return templates.TemplateResponse(
        request=request,
        name="catalogo.html",
        context={"active_tab": active_tab},
    )


@router.get("/nosotros", response_class=HTMLResponse)
async def nosotros(request: Request):
    return templates.TemplateResponse(
        request=request,
        name="nosotros.html",
    )


@router.get("/fragmento_html", response_class=HTMLResponse)
async def fragmento_html(request: Request):
    return templates.TemplateResponse(
        request=request,
        name="cafesia_fragmento.html",
    )
