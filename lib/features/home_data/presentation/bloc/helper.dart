import '../../domain/entities/home_data_entity.dart';

class HomeDataHelper {
  static Future<void> sortItemsAsync(List<HomeDataEntity> items, String column, bool ascending) async {
    if (column == 'date') {
      sortItemsByDateAsync(items, ascending);
    } else if (column == 'name') {
      sortItemsByNameAsync(items, ascending);
    } else if (column == 'qty') {
      sortItemsByQuantityAsync(items, ascending);
    }
  }

  static Future<void> sortItemsByDateAsync(List<HomeDataEntity> items, bool ascending) async {
    items.sort((a, b) {
      if (a.mDate.isEmpty) return ascending ? 1 : -1;
      if (b.mDate.isEmpty) return ascending ? -1 : 1;
      
      try {
        DateTime dateA = DateTime.parse(a.mDate);
        DateTime dateB = DateTime.parse(b.mDate);
        int dateCompare = ascending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
        
        if (dateCompare == 0) {
          return ascending ? a.mName.compareTo(b.mName) : b.mName.compareTo(a.mName);
        }
        
        return dateCompare;
      } catch (e) {
        return ascending ? a.mDate.compareTo(b.mDate) : b.mDate.compareTo(a.mDate);
      }
    });
  }

  static Future<void> sortItemsByNameAsync(List<HomeDataEntity> items, bool ascending) async {
    items.sort((a, b) {
      return ascending ? a.mName.compareTo(b.mName) : b.mName.compareTo(a.mName);
    });
  }

  static Future<void> sortItemsByQuantityAsync(List<HomeDataEntity> items, bool ascending) async {
    items.sort((a, b) {
      return ascending ? a.mQty.compareTo(b.mQty) : b.mQty.compareTo(a.mQty);
    });
  }

  static Future<List<HomeDataEntity>> filterItemsAsync(List<HomeDataEntity> items, String query) async {
    if (query.isEmpty) {
      return List.from(items);
    }

    final lowercaseQuery = query.toLowerCase();

    return items.where((item) {
      if (item.mName.toLowerCase().contains(lowercaseQuery)) {
        return true;
      }

      if (item.mPrjcode.toLowerCase().contains(lowercaseQuery)) {
        return true;
      }

      if (item.mDate.toLowerCase().contains(lowercaseQuery)) {
        return true;
      }

      if (item.mQty.toString().contains(lowercaseQuery)) {
        return true;
      }

      if (item.zcWarehouseQtyImport.toString().contains(lowercaseQuery)) {
        return true;
      }

      if (item.zcWarehouseQtyExport.toString().contains(lowercaseQuery)) {
        return true;
      }

      return false;
    }).toList();
  }
}