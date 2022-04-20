abstract class ShopStates{}

class ShopInitialState extends ShopStates {}
class ShopLoadingState extends ShopStates {}
class ShopErrorState extends ShopStates {}
class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}
class ShopSuccessHomeDataState extends ShopStates {}
class ShopErrorHomeDataState extends ShopStates {}

class ShopLoadingCategoriesState extends ShopStates {}
class ShopSuccessCategoriesState extends ShopStates {}
class ShopErrorCategoriesState extends ShopStates {}
