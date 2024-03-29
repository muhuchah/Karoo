from .models import MainCategory, SubCategory
from rest_framework import generics
from .seryalizers import MainCategorySerializer, SubCategorySerializer


# Reverse List of MainCategories.
class MainCategoryListAPIView(generics.ListAPIView):
    queryset = MainCategory.objects.all()
    serializer_class = MainCategorySerializer


# Reverse List of SubCategories by getting there MainCategory ID.
class SubCategoryListAPIView(generics.RetrieveAPIView):
    serializer_class = SubCategorySerializer

    def get_queryset(self):
        maincategory_id = self.kwargs["pk"]
        queryset = SubCategory.objects.filter(MainCategory_id=maincategory_id)
        return queryset
