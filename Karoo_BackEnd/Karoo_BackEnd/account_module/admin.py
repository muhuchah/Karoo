from django.contrib import admin
from .models import User, DiscountCode, Address, City, Province


class AdminUser(admin.ModelAdmin):
    list_display = [ 'email', 'full_name','is_active', 'phone_number']
    list_filter = ['is_staff','is_active' ]


class AdminDiscountCode(admin.ModelAdmin):
    list_display = [ 'discount_percent', 'code','is_valid']
    list_filter = ['discount_percent']


class CityInline(admin.TabularInline):
    model = City
    extra = 1


class ProvinceAdmin(admin.ModelAdmin):
    list_display = ('name',)
    search_fields = ('name',)
    ordering = ('name',)
    inlines = [CityInline]


class CityAdmin(admin.ModelAdmin):
    list_display = ('name', 'province')
    search_fields = ('name', 'province__name')
    list_filter = ('province',)
    ordering = ('name',)


class AddressAdmin(admin.ModelAdmin):
    list_display = ('user', 'province', 'city')
    search_fields = ('user__username', 'province__name', 'city__name')
    list_filter = ('province', 'city')
    ordering = ('user',)

admin.site.register(User, AdminUser)
#admin.site.register(DiscountCode, AdminDiscountCode)
admin.site.register(Address, AddressAdmin)
admin.site.register(Province, ProvinceAdmin)
admin.site.register(City, CityAdmin)