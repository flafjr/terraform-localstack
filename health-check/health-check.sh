#!/usr/bin/env bash

check_services () {
  QUEUES_OUTPUT="$(awslocal sqs list-queues --output=text)"
  SECRETS_OUTPUT="$(awslocal secretsmanager list-secrets --output=text)"
  SSM_OUTPUT="$(awslocal ssm describe-parameters --output=text)"

  if [[ "$QUEUES_OUTPUT" == *"IndexRestaurantPromotion"* \
  && "$QUEUES_OUTPUT" == *"DeindexRestaurantPromotion"* \
  && "$QUEUES_OUTPUT" == *"RestaurantPromotionWeeklyMetricsNotification"* \
  && "$QUEUES_OUTPUT" == *"RestaurantPromotionNotification"* \
  && "$QUEUES_OUTPUT" == *"UnscheduleRestaurantPromotionNotification"* \
  && "$QUEUES_OUTPUT" == *"RestaurantCreated"* \
  && "$QUEUES_OUTPUT" == *"RestaurantSettingsUpdated"* \
  && "$QUEUES_OUTPUT" == *"RestaurantSkipScoreCalculated"* \
  && "$QUEUES_OUTPUT" == *"RestaurantPromotionTransactionCreated"* \
  && "$QUEUES_OUTPUT" == *"TopPlacementChargeableClicksReceived"* \
  && "$QUEUES_OUTPUT" == *"RestaurantHoursUpdated"* \
  && "$QUEUES_OUTPUT" == *"RestaurantStatusUpdated"* \
  && "$QUEUES_OUTPUT" == *"RestaurantDeliveryPackageChanged"* \
  && "$QUEUES_OUTPUT" == *"RestaurantZonesDeliveryInfoUpdated"* \
  && "$QUEUES_OUTPUT" == *"FreeItemPromotionUpdated"* \
  && "$QUEUES_OUTPUT" == *"RestaurantMenuUpdated"* \
  && "$QUEUES_OUTPUT" == *"RestaurantMenuAvailabilityUpdated"* \
  && "$QUEUES_OUTPUT" == *"TopPlacementDiscountUpdated"* \
  && "$QUEUES_OUTPUT" == *"TopPlacementPromotionUpdated"* \
  && "$QUEUES_OUTPUT" == *"PromotionSignedUp"* \
  && "$QUEUES_OUTPUT" == *"OrderCreated"* \
  && "$QUEUES_OUTPUT" == *"OrderStatusChanged"* \
  && "$QUEUES_OUTPUT" == *"RestaurantPosUpdated"* \
  && "$SECRETS_OUTPUT" == *"dev/restaurant-promotions/rds/restaurant-promotions	"* \
  && "$SSM_OUTPUT" == *"/dev/restaurant-promotions/rds/config"* \
  && "$SSM_OUTPUT" == *"/dev/restaurant-promotions/java/java_opts"* \
  && "$SSM_OUTPUT" == *"/dev/restaurant-promotions/top_placement/config"* \
  && "$SSM_OUTPUT" == *"/dev/restaurant-promotions/free_delivery/config"* \
  && "$SSM_OUTPUT" == *"/dev/restaurant-promotions/free_item/config"* \
  && "$SSM_OUTPUT" == *"/dev/restaurant-promotions/salesforce/config"* \
  && "$SSM_OUTPUT" == *"/dev/restaurant-promotions/frontend/config"* \
  && "$SECRETS_OUTPUT" == *"dev/global/rabbit"* \
  ]]; then
    return 0
  else
    echo "$QUEUES_OUTPUT"
    echo "$SSM_OUTPUT"
    echo "$SECRETS_OUTPUT"

    return 1
  fi
}
check_services
