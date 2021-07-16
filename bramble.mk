# Inherit AOSP product configuration
$(call inherit-product, device/google/bramble/aosp_bramble.mk)

# Remove AOSP prefix from product name
PRODUCT_NAME := bramble
