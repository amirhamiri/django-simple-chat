from django.shortcuts import render, redirect
from django.views.decorators.http import require_http_methods
from .models import Message

@require_http_methods(["GET", "POST"])
def index(request):
    if request.method == "POST":
        name = request.POST.get("name", "").strip()
        content = request.POST.get("content", "").strip()

        if content and len(content) <= 500 and len(name) <= 30:
            Message.objects.create(
                name=name or "ناشناس",
                content=content,
            )
        return redirect("chat")

    latest = list(Message.objects.order_by("-created_at")[:100])
    latest.reverse()
    return render(request, "chat/index.html", {"messages": latest})
