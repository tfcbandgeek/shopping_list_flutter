String poolVersion = "0.1.0";
int poolBuild = 1;

class Pool<T extends PoolObject> {
  int maxSize;
  int minSize;
  int incrementAmount;
  int decrementAmount;
  PoolObjectCreator<T> creator;

  List<T> _pool;

  Pool(
      this.creator,
      {this.minSize = 5,
        this.maxSize = 100,
        this.decrementAmount = 5,
        this.incrementAmount = 5}) {
    _pool = List(minSize);
  }

  T getPoolObject() {
    if (_pool.length <= 0) addToList();
    return _pool.removeAt(0);
  }

  bool hasSize(int size) {
    if (_pool.length >= size) return true;
    return false;
  }

  void ensureSize(int size) {
    while (_pool.length < size) {
      addToList();
    }
  }

  bool underSize(int size) {
    if (_pool.length < size) return true;
    return false;
  }

  void shrinkToSize(int size) {
    if (size > maxSize) size = maxSize;
    while (_pool.length > size) {
      _pool.removeAt(0);
    }
  }

  void addToList() {
    for (int i = 0; i < incrementAmount; i++) {
      _pool.add(creator.createPoolObject());
    }
  }

  void reduceList() {
    for (int i = 0; i < decrementAmount; i++) {
      _pool.removeAt(0);
    }
  }
}

abstract class PoolObject {
  int getID();
  void deconstruct();
}

abstract class PoolObjectCreator<T extends PoolObject> {
  T createPoolObject();
}