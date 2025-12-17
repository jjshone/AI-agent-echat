from fastapi import FastAPI, APIRouter, HTTPException
from pydantic import BaseModel

app = FastAPI(title="AI Agent Backend")

router = APIRouter()


class HealthResponse(BaseModel):
    status: str


@router.get("/health", response_model=HealthResponse)
async def health():
    return {"status": "ok"}


class Order(BaseModel):
    order_id: str
    amount: float


@router.get("/orders/{order_id}", response_model=Order)
async def get_order(order_id: str):
    # Placeholder: in real world fetch from Orders API / DB
    if order_id == "notfound":
        raise HTTPException(status_code=404, detail="order not found")
    return {"order_id": order_id, "amount": 12.34}


app.include_router(router)

# Expose for Uvicorn

if __name__ == "__main__":
    import uvicorn

    uvicorn.run("app.main:app", host="0.0.0.0", port=8000, log_level="info")