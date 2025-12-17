import pytest
from fastapi.testclient import TestClient

from app.main import app

client = TestClient(app)


def test_health():
    r = client.get("/health")
    assert r.status_code == 200
    assert r.json() == {"status": "ok"}


def test_get_order_found():
    r = client.get("/orders/123")
    assert r.status_code == 200
    d = r.json()
    assert d["order_id"] == "123"
    assert "amount" in d


def test_get_order_not_found():
    r = client.get("/orders/notfound")
    assert r.status_code == 404
