// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$requestRepositoryHash() => r'11b7284d71c2ff81101877c7f876fd3bd19e0383';

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

abstract class _$RequestRepository
    extends BuildlessAutoDisposeNotifier<RequestRemoteDataSource> {
  late final Dio dio;

  RequestRemoteDataSource build(Dio dio);
}

/// See also [RequestRepository].
@ProviderFor(RequestRepository)
const requestRepositoryProvider = RequestRepositoryFamily();

/// See also [RequestRepository].
class RequestRepositoryFamily extends Family<RequestRemoteDataSource> {
  /// See also [RequestRepository].
  const RequestRepositoryFamily();

  /// See also [RequestRepository].
  RequestRepositoryProvider call(Dio dio) {
    return RequestRepositoryProvider(dio);
  }

  @override
  RequestRepositoryProvider getProviderOverride(
    covariant RequestRepositoryProvider provider,
  ) {
    return call(provider.dio);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'requestRepositoryProvider';
}

/// See also [RequestRepository].
class RequestRepositoryProvider
    extends
        AutoDisposeNotifierProviderImpl<
          RequestRepository,
          RequestRemoteDataSource
        > {
  /// See also [RequestRepository].
  RequestRepositoryProvider(Dio dio)
    : this._internal(
        () => RequestRepository()..dio = dio,
        from: requestRepositoryProvider,
        name: r'requestRepositoryProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$requestRepositoryHash,
        dependencies: RequestRepositoryFamily._dependencies,
        allTransitiveDependencies:
            RequestRepositoryFamily._allTransitiveDependencies,
        dio: dio,
      );

  RequestRepositoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.dio,
  }) : super.internal();

  final Dio dio;

  @override
  RequestRemoteDataSource runNotifierBuild(
    covariant RequestRepository notifier,
  ) {
    return notifier.build(dio);
  }

  @override
  Override overrideWith(RequestRepository Function() create) {
    return ProviderOverride(
      origin: this,
      override: RequestRepositoryProvider._internal(
        () => create()..dio = dio,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        dio: dio,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<RequestRepository, RequestRemoteDataSource>
  createElement() {
    return _RequestRepositoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RequestRepositoryProvider && other.dio == dio;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, dio.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RequestRepositoryRef
    on AutoDisposeNotifierProviderRef<RequestRemoteDataSource> {
  /// The parameter `dio` of this provider.
  Dio get dio;
}

class _RequestRepositoryProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          RequestRepository,
          RequestRemoteDataSource
        >
    with RequestRepositoryRef {
  _RequestRepositoryProviderElement(super.provider);

  @override
  Dio get dio => (origin as RequestRepositoryProvider).dio;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
