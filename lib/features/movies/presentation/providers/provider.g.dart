// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dictionaryHash() => r'2d6c8bcd42faea8f5f7ad9f9c47a16efce19a4df';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [dictionary].
@ProviderFor(dictionary)
const dictionaryProvider = DictionaryFamily();

/// See also [dictionary].
class DictionaryFamily extends Family<AsyncValue<List<Dictionary>>> {
  /// See also [dictionary].
  const DictionaryFamily();

  /// See also [dictionary].
  DictionaryProvider call({
    required Map<String, dynamic> params,
  }) {
    return DictionaryProvider(
      params: params,
    );
  }

  @override
  DictionaryProvider getProviderOverride(
    covariant DictionaryProvider provider,
  ) {
    return call(
      params: provider.params,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'dictionaryProvider';
}

/// See also [dictionary].
class DictionaryProvider extends AutoDisposeFutureProvider<List<Dictionary>> {
  /// See also [dictionary].
  DictionaryProvider({
    required Map<String, dynamic> params,
  }) : this._internal(
          (ref) => dictionary(
            ref as DictionaryRef,
            params: params,
          ),
          from: dictionaryProvider,
          name: r'dictionaryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dictionaryHash,
          dependencies: DictionaryFamily._dependencies,
          allTransitiveDependencies:
              DictionaryFamily._allTransitiveDependencies,
          params: params,
        );

  DictionaryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.params,
  }) : super.internal();

  final Map<String, dynamic> params;

  @override
  Override overrideWith(
    FutureOr<List<Dictionary>> Function(DictionaryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DictionaryProvider._internal(
        (ref) => create(ref as DictionaryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        params: params,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Dictionary>> createElement() {
    return _DictionaryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DictionaryProvider && other.params == params;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, params.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DictionaryRef on AutoDisposeFutureProviderRef<List<Dictionary>> {
  /// The parameter `params` of this provider.
  Map<String, dynamic> get params;
}

class _DictionaryProviderElement
    extends AutoDisposeFutureProviderElement<List<Dictionary>>
    with DictionaryRef {
  _DictionaryProviderElement(super.provider);

  @override
  Map<String, dynamic> get params => (origin as DictionaryProvider).params;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
