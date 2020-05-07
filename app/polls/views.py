from django.http import HttpResponse
from django.core import serializers

from .models import Question

def index(request):
    ret = []
    questions = Question.objects.all()
    for q in questions:
        ret.append(q)

    return HttpResponse(serializers.serialize('json', ret))
