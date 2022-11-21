export interface ProductData {
  productId: string;
  type: "SUBSCRIPTION" | "NON_SUBSCRIPTION";
}

export const productDataMap: { [productId: string]: ProductData } = {
  fruit_consumable_1: {
    productId: "fruit_consumable_1",
    type: "NON_SUBSCRIPTION",
  },
  fruit_consumable_max: {
    productId: "fruit_consumable_max",
    type: "NON_SUBSCRIPTION",
  },
  remove_ads_upgrade: {
    productId: "remove_ads_upgrade",
    type: "NON_SUBSCRIPTION",
  },
  support_member_subscription_1month: {
    productId: "support_member_subscription_1month",
    type: "SUBSCRIPTION",
  },
  support_member_subscription_1year: {
    productId: "support_member_subscription_1year",
    type: "SUBSCRIPTION",
  },
};
