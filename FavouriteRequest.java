package com.butterflyjewel.dto;

public class FavouriteRequest {
    private Long userId;
    private Long productId;

    public FavouriteRequest() {}

    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }

    public Long getProductId() { return productId; }
    public void setProductId(Long productId) { this.productId = productId; }
}
