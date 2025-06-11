// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$profileRepositoryHash() => r'80c0c69fea2cae2869f1cb16c36d08f1bf75eb2a';

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

abstract class _$ProfileRepository
    extends BuildlessAutoDisposeNotifier<ProfileRemoteDatasource> {
  late final Dio dio;

  ProfileRemoteDatasource build(Dio dio);
}

/// See also [ProfileRepository].
@ProviderFor(ProfileRepository)
const profileRepositoryProvider = ProfileRepositoryFamily();

/// See also [ProfileRepository].
class ProfileRepositoryFamily extends Family<ProfileRemoteDatasource> {
  /// See also [ProfileRepository].
  const ProfileRepositoryFamily();

  /// See also [ProfileRepository].
  ProfileRepositoryProvider call(Dio dio) {
    return ProfileRepositoryProvider(dio);
  }

  @override
  ProfileRepositoryProvider getProviderOverride(
    covariant ProfileRepositoryProvider provider,
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
  String? get name => r'profileRepositoryProvider';
}

/// See also [ProfileRepository].
class ProfileRepositoryProvider
    extends
        AutoDisposeNotifierProviderImpl<
          ProfileRepository,
          ProfileRemoteDatasource
        > {
  /// See also [ProfileRepository].
  ProfileRepositoryProvider(Dio dio)
    : this._internal(
        () => ProfileRepository()..dio = dio,
        from: profileRepositoryProvider,
        name: r'profileRepositoryProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$profileRepositoryHash,
        dependencies: ProfileRepositoryFamily._dependencies,
        allTransitiveDependencies:
            ProfileRepositoryFamily._allTransitiveDependencies,
        dio: dio,
      );

  ProfileRepositoryProvider._internal(
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
  ProfileRemoteDatasource runNotifierBuild(
    covariant ProfileRepository notifier,
  ) {
    return notifier.build(dio);
  }

  @override
  Override overrideWith(ProfileRepository Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProfileRepositoryProvider._internal(
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
  AutoDisposeNotifierProviderElement<ProfileRepository, ProfileRemoteDatasource>
  createElement() {
    return _ProfileRepositoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProfileRepositoryProvider && other.dio == dio;
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
mixin ProfileRepositoryRef
    on AutoDisposeNotifierProviderRef<ProfileRemoteDatasource> {
  /// The parameter `dio` of this provider.
  Dio get dio;
}

class _ProfileRepositoryProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          ProfileRepository,
          ProfileRemoteDatasource
        >
    with ProfileRepositoryRef {
  _ProfileRepositoryProviderElement(super.provider);

  @override
  Dio get dio => (origin as ProfileRepositoryProvider).dio;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
